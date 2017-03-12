defmodule DPW.Helpers do

  @encryption_salt "super-secret-salt"
  @signing_salt "super-secret-signing-salt"

  def set_encrypted_cookie(conn, key, value, opts \\ []) do
    opts = Keyword.put_new(opts, :max_age, 31_536_000) # one year 
    encrypted = Plug.Crypto.MessageEncryptor.encrypt_and_sign(
      :erlang.term_to_binary(value),
      generate(conn, @signing_salt, crypto_opts()),
      generate(conn, @encryption_salt, crypto_opts())
    )

    Plug.Conn.put_resp_cookie(conn, key, encrypted, opts)
  end

  def get_encrypted_cookie(conn, key) do
    case conn.cookies[key] do
      nil -> nil
      encrypted ->
        {:ok, decrypted} = Plug.Crypto.MessageEncryptor.verify_and_decrypt(
          encrypted,
          generate(conn, @signing_salt, crypto_opts()),
          generate(conn, @encryption_salt, crypto_opts())
        )
        :erlang.binary_to_term(decrypted)
    end
  end

  defp crypto_opts() do
    []
  end

  defp generate(conn, key, opts) do
    Plug.Crypto.KeyGenerator.generate(conn.secret_key_base, key, opts)
  end

end

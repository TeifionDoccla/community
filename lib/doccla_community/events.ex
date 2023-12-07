defmodule DocclaCommunity.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias DocclaCommunity.Repo

  alias DocclaCommunity.Events.Webinar

  @doc """
  Returns the list of webinars.

  ## Examples

      iex> list_webinars()
      [%Webinar{}, ...]

  """
  def list_webinars do
    Repo.all(Webinar)
  end

  @doc """
  Gets a single webinar.

  Raises `Ecto.NoResultsError` if the Webinar does not exist.

  ## Examples

      iex> get_webinar!(123)
      %Webinar{}

      iex> get_webinar!(456)
      ** (Ecto.NoResultsError)

  """
  def get_webinar!(id), do: Repo.get!(Webinar, id)

  @doc """
  Creates a webinar.

  ## Examples

      iex> create_webinar(%{field: value})
      {:ok, %Webinar{}}

      iex> create_webinar(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_webinar(attrs \\ %{}) do
    %Webinar{}
    |> Webinar.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a webinar.

  ## Examples

      iex> update_webinar(webinar, %{field: new_value})
      {:ok, %Webinar{}}

      iex> update_webinar(webinar, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_webinar(%Webinar{} = webinar, attrs) do
    webinar
    |> Webinar.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a webinar.

  ## Examples

      iex> delete_webinar(webinar)
      {:ok, %Webinar{}}

      iex> delete_webinar(webinar)
      {:error, %Ecto.Changeset{}}

  """
  def delete_webinar(%Webinar{} = webinar) do
    Repo.delete(webinar)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking webinar changes.

  ## Examples

      iex> change_webinar(webinar)
      %Ecto.Changeset{data: %Webinar{}}

  """
  def change_webinar(%Webinar{} = webinar, attrs \\ %{}) do
    Webinar.changeset(webinar, attrs)
  end
end

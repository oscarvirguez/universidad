#include <vector>
#include "Vertice.h"
#include "Arista.h"

template < class T >
Grafo< T >::Grafo()
{
  std::vector< Vertice < T >* > verts;
  this->vertices = verts;
  std::vector< std::vector < int > > aris;
  this->aristas = aris;
}

template < class T >
Grafo< T >::~Grafo()
{

}

template < class T >
std::vector< Vertice< T >* > Grafo< T >::darVertices()
{
  return this->vertices;
}

template < class T >
void Grafo< T >::setVertices(std::vector< Vertice< T >* > verts)
{
  this->vertices = verts;
}

template < class T >
std::vector< std::vector< int > > Grafo< T >::darAristas()
{
  return this->aristas;
}

template < class T >
void Grafo< T >::setAristas(std::vector< int > aris[])
{
  this->aristas = aris;
}

template < class T >
int Grafo< T >::darOrden()
{
  return this->darVertices().size();
}

template < class T >
int Grafo< T >::darTamanho()
{
  return this->darAristas().size();
}

template < class T >
Vertice< T >* Grafo< T >::buscarVertice( T info )
{
  Vertice< T >* v = NULL;
  bool encontro = false;

  for(int i = 0; i < this->vertices.size(); i++)
  {
    if(this->vertices[i]->darInfo() == info)
    {
      v = this->vertices[i];
      encontro = true;
    }
  }

  return v;
}

template < class T >
bool Grafo< T >::agregarVertice( T info )
{
  if(this->buscarVertice(info) == NULL)
  {
    Vertice< T >* v = new Vertice< T >();
    v->setInfo(info);

    this->vertices.push_back(v);

    std::vector< int > a;
    for(int i = 0; i < this->vertices.size(); i++)
    {
      a.push_back(0);
    }

    this->aristas.push_back(a);

    for(int i  = 0; i < this->aristas.size(); i++)
    {
      for(int j = 0; j < this->vertices.size(); j++)
      {
        if(this->aristas[i].size() < this->vertices.size())
        {
          this->aristas[i].push_back(0);
        }
      }
    }

    return true;
  }

  return false;
}

//template < class T >
//bool Grafo< T >::eliminarVertice( T info );  Reformular

template < class T >
bool Grafo< T >::agregarArista( T infOrigen, T infDestino )
{
  int posOr = -1;
  int posDes = -1;
  Vertice< T >* ori = NULL;
  Vertice< T >* des = NULL;

  for(int i = 0; i < this->darVertices().size(); i++)
  {
    if(this->vertices[i]->darInfo() == infOrigen)
    {
      posOr = i;
      ori = this->vertices[i];
    }

    if(this->vertices[i]->darInfo() == infDestino)
    {
      posDes = i;
      des = this->vertices[i];
    }
  }

  if(this->aristas[posOr][posDes] < 3 && posOr != -1 && posDes != -1 && ori != NULL && des != NULL)
  {
    Arista< T >* ar = new Arista< T >();
    ar->setOrigen(ori->darInfo());
    ar->setDestino(des->darInfo());

    this->aristas[posOr][posDes] += 1;

    if(ori->agregarArista(ar) == false)
    {
      return false;
    }

    if(des->agregarArista(ar) == false)
    {
      return false;
    }

    return true;
  }

  return false;
}

//template < class T >
//bool Grafo< T >::eliminarArista( T infOrigen, T infDestino ); Reformular

template < class T >
void Grafo< T >::desmarcarVertices()
{
  for(int i = 0; i < this->vertices.size(); i++)
  {
    this->vertices[i]->desmarcar();
  }
}

/*template < class T >
int Grafo< T >::darNumeroComponentesConectados()
{
  int cont = this->vertices.size();

  for(int i = 0; i < this->vertices.size(); i++)
  {
    if(this->vertices[i]->darMarca() == false)
    {
      this->vertices[i]->marcarAdyacentes(this);
    }
    else
    {
      cont--;
    }
  }

  this->desmarcarVertices();

  return cont;
}*/

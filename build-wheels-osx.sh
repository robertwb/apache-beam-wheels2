curl -s -o miniconda.sh https://repo.continuum.io/miniconda/Miniconda2-latest-MacOSX-x86_64.sh;
bash miniconda.sh -b -p $HOME/miniconda && rm miniconda.sh;
export PATH="$HOME/miniconda/bin:$PATH"; hash -r;
pip install Cython

cd src
python setup.py bdist_wheel
ls -lh dist

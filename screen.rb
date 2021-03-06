class Screen < Formula
  homepage "https://www.gnu.org/software/screen"

  stable do
    url "http://ftpmirror.gnu.org/screen/screen-4.3.0.tar.gz"
    mirror "https://ftp.gnu.org/gnu/screen/screen-4.3.0.tar.gz"
    sha1 "504c424f719cd44907a3390d5238759e1cb56741"

    # This patch is to disable the error message
    # "/var/run/utmp: No such file or directory" on launch
    patch :p2 do
      url "https://gist.githubusercontent.com/yujinakayama/4608863/raw/75669072f227b82777df25f99ffd9657bd113847/gistfile1.diff"
      sha1 "93d611f1f46c7bbca5f9575304913bd1c38e183b"
    end
  end
  bottle do
    root_url "https://homebrew.bintray.com/bottles-dupes"
    sha256 "d850e98c529e699c49c8deab4c4c6bb0f73ba97c3044c1550973b3e3a5852178" => :yosemite
    sha256 "5828ab7fb89e968e32d9f5dfff13e9251f76e0de37649d805333147f5464c997" => :mavericks
    sha256 "f906e224f750ba29081f6a9e9c65a0cc6263b5550173e689ad655bd6f9bf5927" => :mountain_lion
  end


  head do
    url "git://git.savannah.gnu.org/screen.git"

    # This patch is to disable the error message
    # "/var/run/utmp: No such file or directory" on launch
    patch do
      url "https://gist.githubusercontent.com/yujinakayama/4608863/raw/75669072f227b82777df25f99ffd9657bd113847/gistfile1.diff"
      sha1 "93d611f1f46c7bbca5f9575304913bd1c38e183b"
    end
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    if build.head?
      cd "src"
    end

    # With parallel build, it fails
    # because of trying to compile files which depend osdef.h
    # before osdef.sh script generates it.
    ENV.deparallelize

    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}",
                          "--enable-colors256"
    system "make"
    system "make install"
  end
end

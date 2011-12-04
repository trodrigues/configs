require 'formula'

class Vim < Formula
  homepage 'http://www.vim.org/'
  url 'ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2'
  head 'https://vim.googlecode.com/hg/'
  sha256 '5c5d5d6e07f1bbc49b6fe3906ff8a7e39b049928b68195b38e3e3d347100221d'
  version '7.3.294'

  def features; %w(tiny small normal big huge) end
  def interp; %w(lua mzscheme perl python python3 tcl ruby) end

  def options
    [
      ["--with-features=TYPE", "tiny, small, normal, big or huge (default: normal)"],
      ["--enable-interp=NAME,...", "lua, mzscheme, perl, python, python3, tcl and/or ruby"]
    ]
  end

  def patches
    patch_level = version.split('.').last.to_i
    {'p0' => (1..patch_level).map { |i| 'ftp://ftp.vim.org/pub/vim/patches/7.3/7.3.%03d' % i }}
  end

  def install
    def opt_val(opt)
      opt.sub(/.*?=(.*)$/, "\\1") rescue nil
    end

    opts = []
    feature = opt_val(ARGV.find {|s| s =~ /^--with-features=/ }) || "normal"
    # For compatibility and convenience {{{
    feature_shorthand = features.find {|f| ARGV.include? "--#{f}" }
    feature = feature_shorthand if feature_shorthand
    # }}}
    opts << "--with-features=#{feature}"

    interps = opt_val(ARGV.find {|s| s =~ /^--enable-interp=/ }) || ""
    interps = interps.split(/,/)
    # For compatibility and convenience {{{
    interp.each do |i|
      if ARGV.include? "--#{i}"
        interps << i
      end
    end
    # }}}
    interps.uniq!
    interps.each do |i|
      opts << "--enable-#{i}interp=yes"
      opts << "--with-lua-prefix=/usr/local" if i == "lua"
    end

    system "./configure",
      "--disable-gui",
      "--without-x",
      "--disable-gpm",
      "--disable-nls",
      "--with-tlib=ncurses",
      "--enable-multibyte",
      "--prefix=#{prefix}",
      "--mandir=#{man}",
      *opts
    system "make install"
  end
end

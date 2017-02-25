From: Sami Kerola <kerolasa-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 0/7] pull: make smatch scan output easy to digest
Date: Sat, 25 Feb 2017 17:32:23 +0000 (GMT)
Message-ID: <alpine.LNX.2.20.1702251653080.16457@imuri>
References: <20170213220641.1395-1-kerolasa@iki.fi> <20170220121426.5mr6ab6x7pxt5j4b@ws.net.home> <CAG27Bk2ENHD+1_sX0qVmVnKC2Ss7jDxSyqhNnaj6NKHNnitsYQ@mail.gmail.com> <20170221095012.txqxcblrqkmoxktw@ws.net.home> <20170223153049.GC4133@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170223153049.GC4133@mwanda>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, util-linux <util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

On Fri, 24 Feb 2017, Dan Carpenter wrote:

> On Tue, Feb 21, 2017 at 10:50:12AM +0100, Karel Zak wrote:
> > On Mon, Feb 20, 2017 at 10:12:06PM +0000, Sami Kerola wrote:
> > > On 20 February 2017 at 12:14, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > > Merged, but except:
> > > >
> > > > On Mon, Feb 13, 2017 at 10:06:34PM +0000, Sami Kerola wrote:
> > > >>   misc: unify function declarations [smatch scan]
> > > >
> > > > I agree that some unification would be nice, but don't like
> > > >
> > > >    static __attribute__((__noreturn__)) __attribute__((__format__(printf, 1, 2)))
> > > >           void log_err(const char *fmt, ...);
> > > >
> > > > it would be better to keep all the attributes after declaration:
> > > >
> > > >    static void log_err(const char *fmt, ...)
> > > >                     __attribute__((__noreturn__))
> > > >                     __attribute__((__format__(printf, 1, 2)));
> > > >
> > > > it means new line for each attribute. IMHO it's more readable and you
> > > > don't have to search for the function name, etc.
> > > 
> > > Hi Karel,
> > > 
> > > That's fair enough, and truth is the patch did not fix many warnings so
> > > I am sure we can live with them.
> > > 
> > > What comes to moving attributes at end of the declaration that does
> > > not please smatch.
> > > 
> > > lib/exec_shell.c:33:1: error: attributes should be specified before
> > > the declarator in a function definition
> > >  void exec_shell(void)
> > 
> > Report it as smatch bug. It's pretty common that function attributes
> > are defined after declaration. CC: Dan.
> > 
> 
> This is a Sparse warning, not a Smatch warning.  It shouldn't show up
> when you do a `make checksmatch` so I'm confused by that.  Anyway,
> could you email linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org?

Hi Dan, Karel, and others,

I did not run 'make checksmatch', but added following variables and did 
usual ./configure && make

export CC=/src/smatch/cgcc
export PATH="/src/smatch:$PATH"
export CFLAGS="-Wsparse-all"

With these right now upstream gives errors such as this:

text-utils/more.c:674:43: error: symbol 'end_it' redeclared with different 
type (originally declared at text-utils/more.c:143) - different modifiers

that are caused by lack of function attributes in declaration, while 
fuction has them. An attempt to fix the declarations caused made me to get 
noise about attributes vs declaration order. Such versions of files never 
entered to util-linux, and that is the reason why you do not see these.

See below simple source file that demonstrates how to triggers warning in 
question. When I said was 'smatch' printed warnings it was cgcc that was 
complaining , and therefore this is not really a 'smatch' problem at all. 
Sorry about giving wrong impression.

When comparing gcc with clang gives very similar warning. Perhaps the 
right way to go about this is to reorder attributes to be in front of 
functions after all.

-- snip --

$ cat ./test.c 
#include <stdio.h>
#include <stdlib.h>
static void hello(char *s) __attribute__((__noreturn__));
static void hello(char *s) __attribute__((__noreturn__)) {
        printf("hello %s\n", s);
        exit(0);
}
int main(int argc, char **argv) {
        if (1 < argc)
                hello(argv[1]);
        printf("hello world\n");
        return 0;
}


$ gcc ./test.c 
./test.c:4:1: error: attributes should be specified before the declarator in a function definition
 static void hello(char *s) __attribute__((__noreturn__)) {
 ^~~~~~
./test.c:3:13: warning: 'hello' used but never defined
 static void hello(char *s) __attribute__((__noreturn__));
             ^~~~~
$ gcc --version
gcc (GCC) 6.3.1 20170109
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


$ clang ./test.c 
./test.c:4:43: warning: GCC does not allow '__noreturn__' attribute in this position on a function
      definition [-Wgcc-compat]
static void hello(char *s) __attribute__((__noreturn__)) {
                                          ^
1 warning generated.
$ clang --version
clang version 3.9.1 (tags/RELEASE_391/final)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin


See also:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=60915
https://gcc.gnu.org/onlinedocs/gcc-4.2.2/gcc/Attribute-Syntax.html

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

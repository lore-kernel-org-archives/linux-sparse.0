From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Bug#906472: horst: FTBFS in buster/sid (unable to open 'stdarg.h')
Date: Mon, 24 Sep 2018 18:23:41 +0200
Message-ID: <20180924162339.wfs6pmy33ujvuyem@ltop.local>
References: <E1fqkJB-0004Wc-55@paradis.debian.org> <E1fqkJB-0004Wc-55@paradis.debian.org> <1535227396@msgid.manchmal.in-ulm.de> <20180914140409.GA25593@localhost> <20180914194543.GA22476@taurus.defre.kleine-koenig.org> <E1fqkJB-0004Wc-55@paradis.debian.org>
Reply-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 906472@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.906472.B906472.153780622629535@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20180914194543.GA22476@taurus.defre.kleine-koenig.org>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Christoph Biedl <debian.axhn@manchmal.in-ulm.de>, Santiago Vila <sanvila@debian.org>, 906472@bugs.debian.org, linux-sparse@vger.kernel.org, Adrian Bunk <bunk@debian.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 14, 2018 at 09:45:44PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> [Cc += sparse mailing list]

Sorry for the late answer.
 
> > > Santiago Vila wrote...
> > > 
> > > > 	make -j1 check
> > > > make[1]: Entering directory '/<<PKGBUILDDIR>>'
> > > > sparse -g -O2 -fdebug-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -Wformat -Werror=format-security -std=gnu99 -Wall -Wextra -g -I. -DDO_DEBUG -I/usr/include/libnl3 *.[ch]
> > > > /usr/include/err.h:25:11: error: unable to open 'stdarg.h'
> > > 
> > > To reproduce this it's important to remove gcc-7 from the build chroot
> > > (apt purge libgcc-7-dev ; apt --purge autoremove).
> > > 
> > > Problem is, sparse appearently uses hardcoded paths and looks for
> > > stdarg.h in (among other places)

Well, sparse needs to know where it can find the system header files.
There is an option for this: -gcc-base-dir (and -multiarch-dir).
Usually you will want to use either some that are installed by your
distro or the one that match the exact GCC version you're using.

By *default*, if no -gcc-base-dir is used, sparse use the same dir
as the one used by the GCC used to compile sparse itself. It's only
this default that is hardcoded.

> > > Solution is to rebuild sparse, building horst was successful then.
> > > If this is true (please check!), the interesting question is why this
> > > wasn't a problem in earlier gcc version bumps.
> 
> I think this is a known limitation of sparse and there are three
> ways to fix this (in my order of preference):
> 
>  a) let horst use cgcc -no-compile instead of sparse; or
>  b) let sparse depend on libgcc-7-dev (or whatever provides the
>     necessary files); or
>  c) use autodetection which gcc is used and pick its files.
>
> I'm not sure if a) fixes the problem. It fixed another problem we had
> with horst's usage of sparse in the past though[1].
> 
> The downside of c) is that running this autodetection on every call to
> sparse is probably slowing down sparse a bit which isn't nice.

In case the default can't be used, like here, I think the best is
to add in your Makefile something like:
	GCC_BASE_DIR=$(shell $(CC) -print-file-name=)
	SPARSE_FLAGS= -gcc-base-dir $(GCC_BASE_DIR)
	...
		sparse $(SPARSE_FLAGS) ...

This doesn't need to be done at each invocation of sparse (but will be done
at each top-level make invocation).

Regards,
-- Luc

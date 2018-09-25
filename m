From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Bug#906472: horst: FTBFS in buster/sid (unable to open 'stdarg.h')
Date: Tue, 25 Sep 2018 19:06:02 +0200
Message-ID: <20180925170601.gonqbd6eatgd5rzj@ltop.local>
References: <E1fqkJB-0004Wc-55@paradis.debian.org> <E1fqkJB-0004Wc-55@paradis.debian.org> <1535227396@msgid.manchmal.in-ulm.de> <20180914140409.GA25593@localhost> <20180914194543.GA22476@taurus.defre.kleine-koenig.org> <20180924162339.wfs6pmy33ujvuyem@ltop.local> <8160e494-8548-761c-07c0-83aa0b97b075@kleine-koenig.org> <E1fqkJB-0004Wc-55@paradis.debian.org>
Reply-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 906472@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.906472.B906472.153789517023882@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <8160e494-8548-761c-07c0-83aa0b97b075@kleine-koenig.org>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Christoph Biedl <debian.axhn@manchmal.in-ulm.de>, Santiago Vila <sanvila@debian.org>, 906472@bugs.debian.org, linux-sparse@vger.kernel.org, Adrian Bunk <bunk@debian.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Sep 25, 2018 at 04:38:01PM +0200, Uwe Kleine-König wrote:
> > By *default*, if no -gcc-base-dir is used, sparse use the same dir
> > as the one used by the GCC used to compile sparse itself. It's only
> > this default that is hardcoded.
> 
> I wasn't sure if this is expected to work. I had in mind, that the
> version of gcc is used somewhere but couldn't find proof for that.

Several other flags have their default value corresponding to the
GCC used to compile sparse: for example the architecture (x86, x86-64)
or the endianness. The one you're thinking about is probably the macros
for the GCC version: __GNUC__, __GNUC_MINOR__ & __GNUC_PATCHLEVEL__.

As far as I know, everything that should matter can be set explicitly
either by defining the macro via -D...=... or an explicit flag like
-m{32,64}, -m{little,big}-endian, -funsigned-char, ...

When using sparse for userspace code, it may be best to use the cgcc
wrapper since it take care to set (some of) these values. I'm saying
'may' because personnaly, I have no experience of using sparse via
cgcc (as an user, I've only used sparse for OS or bare-metal code)
but I know others use it like so (for example for git).

> > In case the default can't be used, like here, I think the best is
> > to add in your Makefile something like:
> > 	GCC_BASE_DIR=$(shell $(CC) -print-file-name=)
> > 	SPARSE_FLAGS= -gcc-base-dir $(GCC_BASE_DIR)
> > 	...
> > 		sparse $(SPARSE_FLAGS) ...
> 
> IMHO it is sensible to let sparse depend on (or at least recommend) gcc.
> And then the default value should be right.
> 
> > This doesn't need to be done at each invocation of sparse (but will be done
> > at each top-level make invocation).
> 
> I'd say you'd need := for this effect instead of =.

Yes, indeed.

> Best regards and thanks for your valuable input,
> Uwe

You're very welcome,
-- Luc

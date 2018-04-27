From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Bug#873508: sparse test failures on x32
Date: Fri, 27 Apr 2018 09:43:31 +0200
Message-ID: <20180427074330.jnnt2ehucolzgltp@ltop.local>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org> <779a85fe-0691-0f8b-c70a-85df449003bc@kleine-koenig.org> <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
Reply-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 873508@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.873508.B873508.152481501620831@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <779a85fe-0691-0f8b-c70a-85df449003bc@kleine-koenig.org>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Apr 27, 2018 at 07:56:38AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On 08/30/2017 06:14 PM, Uwe Kleine-König wrote:
> > Antoine Beaupre (on Cc:) noticed that sparse doesn't work on some not so
> > common architectures like ppc32le, s390x, ppc64 and sparc64[1]. This is
> > nicely catched by the testsuite, e.g.:
> >
> > [..]
> 
> Just a heads up: I uploaded 0.5.2 to Debian and there are problems left
> ...
> and x32 where I get:
> 
> 	env CHECK=./sparse ./cgcc -no-compile memops.c
> 	/usr/include/x86_64-linux-gnux32/gnu/stubs.h:10:12: error: unable to
> open 'gnu/stubs-64.h'
> 
> The stubs.h file looks as follows:
> 
> #if !defined __x86_64__
> # include <gnu/stubs-32.h>
> #endif
> #if defined __x86_64__ && defined __LP64__
> # include <gnu/stubs-64.h>
> #endif
> #if defined __x86_64__ && defined __ILP32__
> # include <gnu/stubs-x32.h>
> #endif
> 
> Given that libc6-dev only provides stubs-x32.h from these three, I guess
> we must not define __LP64__ in this case.

Mmmm, yes, surely.
For the moment sparse use __LP64__ unconditionnaly for __x86_64__.

> I don't have a x32 machine

But can you launch a test build for sparse easily enough?
I guess that there is no install CD available yet?


-- Luc

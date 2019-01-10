From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Bug#873508: sparse test failures on ppc32le (and other not so common archs)
Date: Thu, 10 Jan 2019 12:39:32 +0100
Message-ID: <20190110113931.takknuklkbebzeij@ltop.local>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org> <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com> <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org> <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com> <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org> <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com> <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org> <87sgy1uty1.fsf@curie.anarc.at> <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
Reply-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 873508@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.873508.B873508.154712037716119@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <87sgy1uty1.fsf@curie.anarc.at>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Antoine =?UTF-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org
List-Id: linux-sparse@vger.kernel.org

On Wed, Jan 09, 2019 at 09:28:54PM -0500, Antoine Beaupré wrote:
> Control: forwarded -1 https://github.com/br101/horst/issues/93

Hi,

The issue showed there, more precisely the one:
  /usr/include/x86_64-linux-gnu/bits/mathcalls-helper-functions.h:21:1: error: Expected ) in function declarator
is caused by sparse's lack of support for _Float128 and occurs with
recent version of glibc.

This has been fixed and upstreamed (see
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/?id=4e9c8ee467dd87d41d5aaa3c5a487e3f05ffb79c
for more details).
 
Best regards,
-- Luc

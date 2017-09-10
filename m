From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Bug#873508: sparse test failures on ppc32le (and other not so common archs)
Date: Sun, 10 Sep 2017 14:29:07 +0200
Message-ID: <CAExDi1Tz0Y=TVt2QDB2tJ4H4fcgczTe3JEuMvVWWGsHhN2JSOA@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org> <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com> <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org> <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com> <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org> <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com> <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org> <CAExDi1SRgOj8qKvxR6O56hbmXS6mDQbkTEhpSUZkRamJMaaqZw@mail.gmail.com> <df2139ba-8ac3-00c7-5c46-896f15c13671@kleine-koenig.org> <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
Reply-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 873508@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-rc=glddbr-debian-bugs-rc=gmane.org@lists.debian.org>
Sender: luc.vanoostenryck.ml@gmail.com
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.873508.B873508.150504655214788@bugs.debian.org>
Sender: luc.vanoostenryck.ml@gmail.com
In-Reply-To: <df2139ba-8ac3-00c7-5c46-896f15c13671@kleine-koenig.org>
List-URL: <https://lists.debian.org/debian-bugs-rc/>
List-Post: <mailto:debian-bugs-rc@lists.debian.org>
List-Help: <mailto:debian-bugs-rc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=unsubscribe>
To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>
List-Id: linux-sparse@vger.kernel.org

On Sun, Sep 10, 2017 at 10:43 AM, Uwe Kleine-K=C3=B6nig
<uwe@kleine-koenig.org> wrote:
>
>> Meanwhile, is it possible to have the build logs but with 'make V=3D1 ..=
.' ?
>> It would also be useful to have:
>> - the output of 'uname -a'
>> - the details about the version of LLVM you're using
>
> Sure, can do. Attached is a build from the ppc64el machine with Chris'
> patch applied. Tell me if it contains everything you need.

I've taken a look at it what happens.
The problem is easy to identify and very annoying to solve:
in sparsec (a wrapper for sparse-llvm + llc + as [+ ld]) there
is a discrepancy between the defaults for llc and as.
'llc' seems to default to the sub-architecture of the build machine
(possibly including the most modern features) while 'as' defaults
to the minimal features for the build machine architecture.

The problem can be solved (on the machine I have access to) by either:
- using the option "-mgeneric" for llc
- using the option "-mpower8" for as

Something smarter would be better.

-- Luc

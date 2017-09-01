From: Antoine =?UTF-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Subject: Bug#873508: sparse test failures on ppc32le (and other not so common archs)
Date: Fri, 01 Sep 2017 07:33:59 -0400
Message-ID: <87mv6ezm8o.fsf@curie.anarc.at>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org> <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com> <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org> <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com> <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org> <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com> <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org> <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
Reply-To: Antoine =?UTF-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>, 873508@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.873508.B873508.150426564416785@bugs.debian.org>
In-Reply-To: <20170901074643.rivm2rit53mavkjr@taurus.defre.kleine-koenig.org>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org
List-Id: linux-sparse@vger.kernel.org

On 2017-09-01 09:46:44, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Thu, Aug 31, 2017 at 11:43:53PM +0100, Ramsay Jones wrote:
>> On 31/08/17 21:55, Uwe Kleine-K=C3=B6nig wrote:
>> > On Wed, Aug 30, 2017 at 08:11:49PM -0400, Christopher Li wrote:
>> >> That is very much like on x86_64 missing define "#weak_define __x86_6=
4__ 1"
>> >>
>> >> Does cgcc work for you? In the future we do want to move the archetec=
ture
>> >> related define from cgcc into sparse by itself. For now you can set
>> >> "sparse" as "cgcc -no-compile"
>> >=20
>> > Yes that works. So to address the Debian bug I can do:
>> >=20
>> >  - move sparse to /usr/lib
>> >  - teach cgcc about the move of sparse
>> >  - make /usr/bin/sparse call cgcc -no-compile "$@"
>>=20
>> Hmm, I don't think that would be a good idea ...
>>=20
>> > or is it easier to teach sparse about the architecture stuff?
>>=20
>> I now understand (I think!) that you are building a sparse
>> package (presumably a .deb) and you are concerned that sparse
>> does not pass it's own testsuite on those platforms.
>
> Nearly right. I'm responsible for the sparse Debian package and the
> problem at hand is https://bugs.debian.org/873508. This bug report has
> "Severity: serious" wihch might eventually result in the removal of
> sparse from the Debian archive.
>
> @anarcat: Given that cgcc seems to work, would you agree to apply the
> following patch to horst:
>
> diff --git a/Makefile b/Makefile
> index 4f924fa..d563652 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -110,7 +110,7 @@ $(NAME): $(OBJS)
>  $(OBJS): .buildflags
>=20=20
>  check:
> -	sparse $(CFLAGS) *.[ch]
> +	cgcc -no-compile $(CFLAGS) *.[ch]
>=20=20
>  clean:
>  	-rm -f *.o radiotap/*.o *~
>
> and downgrade the bug to "important"? That would be a compromise that
> buys us a bit of time.

Well right now I have simply disabled the checks for those broken
architectures, so sparse isn't as affected anymore.

Frankly, I don't quite know what to do with this - but I'd be happy to
happly that patch to sparse if it fixes the issue better.

A.

--=20
Those who would give up essential Liberty, to purchase a little
temporary Safety, deserve neither Liberty nor Safety.
                        - Benjamin Franklin, 1755

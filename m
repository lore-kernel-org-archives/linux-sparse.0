From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Tue, 15 May 2012 02:44:49 -0700
Message-ID: <CANeU7QmfxzQ8xXObV+PzLBZ62Amw13dY+-9OEa2K9QLGh4eKRg@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com>
	<4FA767BD.8060703@gaisler.com>
	<CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com>
	<4FA8BF7D.60606@gaisler.com>
	<CANeU7QkLrr1p8-Bofx9fnZ82BA2pc7sOxSOa-zim5NhWHXTNQA@mail.gmail.com>
	<4FAA3D50.8080901@gaisler.com>
	<CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com>
	<4FAB5DEA.5060009@gaisler.com>
	<4FAB6268.7070908@gaisler.com>
	<CANeU7Qk-DTs+WL=u2g5WQ1L2J++ZBkCHi8_85bmUWto7rq0-9Q@mail.gmail.com>
	<4FAB8F9E.8040205@gaisler.com>
	<CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail.com>
	<4FABB132.1070308@gmail.com>
	<4FABB467.7030703@gmail.com>
	<CANeU7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com>
	<4FAD892B.8070709@gmail.com>
	<CANeU7QnEyUExcxaoVEeamhu1m+Z_pg0TpKBP00hh+gyPgdq66w@mail.gmail.com>
	<4FAEA208.3090601@gmail.com>
	<4FAF7645.9040003@gmail.com>
	<CANeU7QnOtrWFvmd4Od1gU_uHccjSQdD7pNGC4ri4pTCU=GcwLg@mail.gmail.com>
	<4FB20B37.8070308@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51451 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab2EOJou convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 May 2012 05:44:50 -0400
Received: by gglu4 with SMTP id u4so3995894ggl.19
        for <linux-sparse@vger.kernel.org>; Tue, 15 May 2012 02:44:49 -0700 (PDT)
In-Reply-To: <4FB20B37.8070308@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Konrad Eisele <eiselekd@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, May 15, 2012 at 12:52 AM, Konrad Eisele <konrad@gaisler.com> wr=
ote:
> The last patch with mdep.c and test-mdep.c was also nothing to
> apply, only a work in progress to go further...

OK, I mistaken that as apply request. Never mind some of the
coding style comment then.

> One thing you can see is how I propagate the token sources
> using:
>
> 137: =A0 =A0 =A0 =A0 =A0 =A0n->from =3D list->pos;
> ...
> 143: =A0 =A0 =A0 =A0 =A0 =A0list->pos.line =3D id;
> 144: =A0 =A0 =A0 =A0 =A0 =A0list->pos.stream =3D pps;
>
> here you get an argument why it is better to have a
> (1) ->macro_begin(a)
> =A0 =A0->macro_end(b)
> instead of only one
> (2) expand_macro(a,b)
> If you want to use the preprocessorhooks to output human readable mac=
ro
> expansion history line similar to LLVM you probably want a pointer
> to the "pre-expanded" token location, that is in (a). In (1) you can =
buildup
> the token-source-paths going from post-expand buffer (b) through the
> pre-expanded buffers (a)
> in (2) you only have the paths going through the expanded buffers, ca=
n use
> (a) to reason
> about where (b) came from, but =A0not in a simple way...

At this point I think  1) is actually better for your requirement.
I start out as hoping the expand_macro() can abstract away the
internal implementation detail of macro expand and just give you the
text before and after the macro expand. But with all this extra
manipulations of the macro tokens, especially the substitute_argument()
is clear indicate tightening into the implementation details.

I would take 1) over substitute_arguments() if 1) don't need call back =
like
substitute_arguments().


> Kindof something like this:
> #define E1
> #define E2
> #define S1(a) struct a { E1 int d1; };
> #define S2(a) struct a { E2 int d2; };
> #define xdef S1(sx) S2(sy)
> xdef
> main() {
> =A0 =A0 =A0 =A0struct sx v;
> }
>
> The xdef expands in one-line to "struct sx { int d1; }; struct sy { i=
nt d1;
> };"
> main() only uses "struct sx". Therefore the dependency analysis shoul=
d not
> have "E2 and S2" as dependencies. I think you need the location of em=
pty

That is surprising to me. I previously have different assumptions.
I assume you want to back trace all the way back to the source macro.
I would just say main() depend on xdef, which depend one S1 and S2.
S1 also depend on E1 and S2 depend on E2.

If you bypass xdef and directly extract S1(sx). Why can't you do one
step further bypass S1() as well,  and say main depend on "struct sx {
E1 int d1;}?

This is even more complicated than I original though.
How about this case:

#define S1(a) struct a { E1 int d1; }; E3 struct
#define S2(a) a { E2 int d2; };

The rest is the same. Now xdef will expand to the same text.
What should main() depend on?  S1, E1 and E3?
Notice that without S2, macro expand by S1 can't compile at all.

> Do you mean http://cfw.sourceforge.net/htmltag/init_32.c.pinfo.html ?=
 This
> is a gcc-based patch even there you need to trace empty expansion pos=
itions.

Yes. Did that patch submit to gcc? I can see trace empty expansion one =
level.
You track empty macro pass that one multiple level macro expand as well=
?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

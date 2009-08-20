From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fixing "cast truncates bits from constant value"
Date: Wed, 19 Aug 2009 23:55:18 -0700
Message-ID: <70318cbf0908192355j32feec13r12b9ce62697b5bb9@mail.gmail.com>
References: <1250542922.10511.38.camel@mj>
	 <70318cbf0908182236h21c5d342o15bb658a445fc476@mail.gmail.com>
	 <1250724487.23170.72.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:38140 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbZHTGzS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 20 Aug 2009 02:55:18 -0400
Received: by vws2 with SMTP id 2so4210583vws.4
        for <linux-sparse@vger.kernel.org>; Wed, 19 Aug 2009 23:55:19 -0700 (PDT)
In-Reply-To: <1250724487.23170.72.camel@mj>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Wed, Aug 19, 2009 at 4:28 PM, Pavel Roskin<proski@gnu.org> wrote:
>
> static unsigned short test(void)
> {
> =A0 =A0 =A0return (unsigned short)(0xffff & ~0x8000);
> }
>
> I think it's ugly. =A0And that's what b43 developers think, so the sp=
arce
> warning remains unfixed.


You can use a macro with nice name to do the convert plus AND 0xffff.
e.g.

return short_value(~0x8000);


>
>> > In my opinion, an explicit cast should be enough to suppress the
>> > warning. =A0But it's not. =A0Moreover, it's a "superwarning" that =
cannot
>> > even be suppressed by the "force" attribute! =A0This source still
>> > generates a warning:
>> >
>> > static unsigned short test(void)
>> > {
>> > =A0 =A0 =A0 =A0return (__attribute__((force)) unsigned short)~0x80=
00;
>>
>> Sparse currently does not thing than just mark it as forced.
>
> The whole point of having that attribute is to suppress warnings.

Yes, there is a lot of place sparse is complete yet. If any one want
to send patches. I am glad to review it.

>> > static unsigned short test(void)
>> > {
>> > =A0 =A0 =A0 =A0return 0xfffff000U;
>> > }
>>
>> I think sparse consider it as signed extend.
>> Truncating all 0xffff is consider OK for the negative case.
>
> That's wrong, as there are no signed integers involved in the above
> example.

True. But sparse is not a validations tool. It just point out the possi=
ble
warnings. If a warning has too much false positives. It is pretty much
useless. What you are suggesting will cause too much unnecessary
warnings. I haven't try it myself, but I suspect the kernel using negat=
ive
error code in pointers might trigger this.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Mon, 29 Mar 2010 11:05:08 -0700
Message-ID: <70318cbf1003291105v44334f0et82575f62a8c187f8@mail.gmail.com>
References: <1268097872.16227.10.camel@mj>
	 <201003211627.14164.kdudka@redhat.com>
	 <70318cbf1003240307m6be38384l3524923484e493ce@mail.gmail.com>
	 <201003271016.39291.kdudka@redhat.com> <20100327092949.GB9548@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45794 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab0C2SFK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Mar 2010 14:05:10 -0400
Received: by vws20 with SMTP id 20so132318vws.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Mar 2010 11:05:09 -0700 (PDT)
In-Reply-To: <20100327092949.GB9548@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Sat, Mar 27, 2010 at 2:29 AM, Josh Triplett <josh@joshtriplett.org> =
wrote:
>> =A0 =A0 .type =3D (enum keyword) (KW_SPECIFIER | KW_SHORT),
>> =A0 =A0 lookup_keyword(token->ident, (enum namespace) (NS_KEYWORD | =
NS_TYPEDEF));
>
> That looks wrong. =A0.type doesn't contain a value of type "enum keyw=
ord",
> it contains the bitwise or of such values, which won't represent a va=
lid
> enum value. =A0Thus, .type should have an integral type, not an enum =
type.
> The same goes for the second parameter of lookup_keyword.

According to the new "strict enum" rules which don't allow enum type to=
 accept
value other than the enum list above, that is right.

But I argue that this strict enum rules does not make sense, after this=
 change,
the code don't not gain any thing. In fact, it looks worse.

Sparse use a loosely define enum namespace for member "namespace". It m=
eans
it has all this basic enum value, from NS_MACRO to NS_KEYWORD. In my mi=
nd,
all combination of this value consider enum namespace as well. It is
just that I can't
list all of them in the enum list.

Using enum namespace for member "namespace" has benefit here. It is cle=
ar that
which set of value it belongs to. E.g. if you assign SYM_NODE into "nam=
espace"
member it *looks* is obvious wrong.

It also helps people understand which set of value belongs to
"namespace" member.
Make "namespace" a plain int, that message is lost. It become very
confusing for new comer
what value was allowed in this int type.

So back to my point. It seems making the enum more strict is just make =
up rules
and gain nothing in real life. It makes code looks worse just to make
strict enum type
happy.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

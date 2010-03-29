From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Mon, 29 Mar 2010 11:48:38 -0700
Message-ID: <70318cbf1003291148w6b338b25v6801c3ec146af0f9@mail.gmail.com>
References: <1268097872.16227.10.camel@mj> <20100327092949.GB9548@feather>
	 <70318cbf1003291105v44334f0et82575f62a8c187f8@mail.gmail.com>
	 <201003292017.16866.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:58024 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab0C2Ssk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Mar 2010 14:48:40 -0400
Received: by gxk9 with SMTP id 9so1790222gxk.8
        for <linux-sparse@vger.kernel.org>; Mon, 29 Mar 2010 11:48:39 -0700 (PDT)
In-Reply-To: <201003292017.16866.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Mon, Mar 29, 2010 at 11:17 AM, Kamil Dudka <kdudka@redhat.com> wrote=
:
> On Mon March 29 2010 20:05:08 Christopher Li wrote:
>> Using enum namespace for member "namespace" has benefit here. It is =
clear
>> that which set of value it belongs to. E.g. if you assign SYM_NODE i=
nto
>> "namespace" member it *looks* is obvious wrong.
>
> We are able to catch assignment of SYM_NODE to 'enum namespace'. =A0B=
ut we are
> not able to catch (SYM_NODE | SYM_ENUM) to 'enum namespace', so that =
the patch
> makes no difference. =A0Or am I missing anything?

I am refering to your patch in other email:

struct symbol_op {
-          enum keyword type;
+         int type;

That is worse. Because you make type as plain int, I can assign NS_KEYW=
ORD there
and you wouldn't able to catch any thing right? So you make the enum
so strict that
we can't use it any more.

Currently the compiler might not able to catch it. But it look obvious
wrong to human
eye if you assign other class of enum there.

>
> I don't think the code looks worse, nevertheless respect your attitud=
e.

See my previous comment.

I just want to make sense of this thing. Currently I see a lot of down =
sides,
forcing people to do more explicit cast or avoid using the enum type co=
mpletely.
What is the up side again?

Remember, too much warning can be a bad thing as well. It makes people
don't want
to use the tool or just turn off the warning completely. When I run spa=
rse over
its own source code, I consider those warning useless because I don't
have a better
way to fix it. I think the source code is fine as it is.

BTW, I have move the enum warning to a new branch:

http://git.kernel.org/?p=3Ddevel/sparse/sparse.enum-warning.git;a=3Dsum=
mary

Some people might find it useful in special occasions. I want to heard =
about it.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

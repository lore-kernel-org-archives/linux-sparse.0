From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: add LLVM code generation backend
Date: Mon, 27 Apr 2009 19:15:26 -0700
Message-ID: <70318cbf0904271915m6cdc0dc4t4eed01d075f17036@mail.gmail.com>
References: <20090426205806.GA20933@havoc.gtf.org>
	 <70318cbf0904271215o48ac3952ua0aca68a50cba16d@mail.gmail.com>
	 <49F6342B.30605@garzik.org>
	 <70318cbf0904271627w25df616di12e5b1454e89764f@mail.gmail.com>
	 <49F64E9A.2030009@garzik.org>
	 <70318cbf0904271804i4b8a14cbqfa62f521dc7258a3@mail.gmail.com>
	 <49F65A1A.50300@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:34541 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZD1CP2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 22:15:28 -0400
Received: by rv-out-0506.google.com with SMTP id f9so191482rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Apr 2009 19:15:26 -0700 (PDT)
In-Reply-To: <49F65A1A.50300@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Apr 27, 2009 at 6:21 PM, Jeff Garzik <jeff@garzik.org> wrote:
> Christopher Li wrote:
>>
>> On Mon, Apr 27, 2009 at 5:32 PM, Jeff Garzik <jeff@garzik.org> wrote=
:
>>>
>>> Not true -- I can walk SYM_STRUCT of the function arguments' base_t=
ype
>>> passed to a SYM_FN. =A0Similarly so for struct-based variable decla=
rations.
>>>
>>> With that information, you can easily back-reference lvalue uses to=
 the
>>> original struct.
>>
>> Let say I follow this route, isn't that you can apply the same trick=
 for
>> the
>> linearize instruction case? struct instruction has a type member giv=
e a
>> pointer to C type.
>>
>> I still don't see a reason why you have to use your own AST recursiv=
e
>> code.
>
> You mean, besides the reasons already listed? =A0Namely, no upstream =
changes
> are required, and I already have something that works.
>
> Sure, the same trick can be applied. =A0But that requires a total bac=
kend
> rewrite plus dealing with linearize obstacles already described (ref
> linearize_load_gen, linearize_store_gen). =A0Thus it is obviously a l=
ot more

OK. The current handling of linearize_load_gen and linearize_store_gen =
is
annoying when you try to treat bit field as a type. On the other hand, =
your
V2 patch does not have bit field (yet).

In the long run, I would rather have only one implementation of the
linearization.

I will take a look at how LLVM does bit fields and get back to you.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

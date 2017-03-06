From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Mon, 6 Mar 2017 17:06:01 +0000
Message-ID: <CACXZuxc3fDdh9OwKN4LGtEn=rf7rGe=GNn9Z_-3GevFa4yqWnw@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com> <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
 <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
 <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com> <20170306164306.hibukuy2t4j4camh@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:38342 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753770AbdCFRGE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 12:06:04 -0500
Received: by mail-it0-f46.google.com with SMTP id m27so54335597iti.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 09:06:04 -0800 (PST)
In-Reply-To: <20170306164306.hibukuy2t4j4camh@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 6 March 2017 at 16:43, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 07, 2017 at 12:22:07AM +0800, Christopher Li wrote:
>> On Mon, Mar 6, 2017 at 11:32 PM, Dibyendu Majumdar
>> <mobile@majumdar.org.uk> wrote:
>> >
>> > Sparse-llvm appears to bypass the normal struct GEP in LLVM. It
>> > basically casts everything to char *, uses GEP to obtain a pointer to
>> > member, and then casts it back to member type. So this should work for
>> > structs and unions.
>>
>> That is exactly my question. I haven't understand how this by pass
>> can work in all the situation.
>>
>> >
>> > This case is more about handing pointer arithmetic correctly. Here GEP
>> > is being used as array element access and not for struct member
>> > access.
>>
>> Even using array element access, I still have some question regarding
>> the the mapping process of the array index.
>> Correct me if I am wrong, the GEP indices are express as array index.
>> So after convert to (char*) + offset, the offset will express as
>> n*(sizeof(element type)).
>> "n" is the array index.
>>
>> However, the OP_ADD instruction, the offset is byte offset value. The offset
>> part might not be align to n*(sizeof(array_elelment)). Assume we can use
>> some pack struct to get some member located not at the natural alignment offset.
>>
>> Even if the offset is at the type size alignment, shouldn't the indices express
>> as ( offset / sizeof(element type))? What do I miss?
>
> With an example:
> == C code ==
>         void *foo(int *p) { return p + 5; }
>
> == linearized code ==
>         foo:
>         .L0:
>                 <entry-point>
>                 add.64      %r2 <- %arg1, $20
>                 cast.64     %r3 <- (64) %r2
>                 ret.64      %r3
>
> == LLVM code from sparse-llvm ==
>         ; ModuleID = '<stdin>'
>         source_filename = "sparse"
>
>         define i8* @foo(i32* %ARG1) {
>         L0:
>           %0 = getelementptr i32, i32* %ARG1, inttoptr (i64 20 to i32*)
>           %R3 = bitcast i32* %0 to i8*
>           ret i8* %R3
>         }
>

This may be the issue Chris is highlighting -  above the offset should
be 5 not 20 in the LLVM code as the array type is i32* not i8*. Does
sparse always output array offsets in char*?

Regards
Dibyendu

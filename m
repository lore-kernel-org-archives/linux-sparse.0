From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2] sparse: treat function pointers as pointers to const data
Date: Sun, 7 Sep 2014 19:29:57 +0200
Message-ID: <CAKv+Gu-5=RKD55FZTL7wWuy5P9WdjyXEddtggS=6UGKj-FXPgA@mail.gmail.com>
References: <1410093413-3075-1-git-send-email-ard.biesheuvel@linaro.org>
	<20140907171442.GA24467@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:53634 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbaIGR36 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Sep 2014 13:29:58 -0400
Received: by mail-lb0-f170.google.com with SMTP id s7so1404125lbd.29
        for <linux-sparse@vger.kernel.org>; Sun, 07 Sep 2014 10:29:57 -0700 (PDT)
In-Reply-To: <20140907171442.GA24467@thin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: sparse@chrisli.org, linux-sparse@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On 7 September 2014 19:14, Josh Triplett <josh@joshtriplett.org> wrote:
> On Sun, Sep 07, 2014 at 02:36:53PM +0200, Ard Biesheuvel wrote:
>> This code snippet:
>>
>> static void bar(void const *arg)
>> {
>>       int (*foo)(void) = arg;
>> }
>>
>> produces the following warning:
>>
>> test.c:4:28: warning: incorrect type in initializer (different modifiers)
>> test.c:4:28:    expected int ( *foo )( ... )
>> test.c:4:28:    got void const *arg
>>
>> which is caused by the fact that the function pointer 'foo' is not annotated
>> as being a pointer to const data. However, dereferencing a function pointer
>> does not produce an lvalue, so a function pointer points to const data by
>> definition, and we should treat it accordingly.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> As a data point: gcc does not warn about this case either, whereas it
> does warn about "int *foo = arg".  So, this seems fine to me.
>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
>
>> OK, so while my v1 did solve the example case, it turns out universally treating
>> function pointers as pointers to const data produces so much fallout that it
>> does more harm than good.
>
> Can you elaborate on the fallout, and ideally provide that rationale in
> the commit message?
>

Treating a function pointer as pointer-to-const-data in every
occurrence results in sparse triggering on the inverse case, i.e.

extern int (*foo)(void);
void *arg = foo;

which is a pattern that is widely used in the kernel, arguably
incorrect (considering the nature of a function pointer) but not the
case I intended to address.

I will put something to that effect in the v3 commit message.

Cheers,
Ard.

From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v6] sparse: add support for _Static_assert
Date: Tue, 9 May 2017 16:21:07 -0700
Message-ID: <CANeU7Q=n2LkU=rLZJMEDvSuStX3+U2QRFRWqdVhMzH7pZPcGMA@mail.gmail.com>
References: <20170508211543.20681-1-lrichard@redhat.com> <CANeU7Q=oVwcFtB-RhG0+iFoHsF2BR+_wMZ4MP4x+ZmKDfvatew@mail.gmail.com>
 <508829304.6362470.1494351759113.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35586 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdEIXVJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 May 2017 19:21:09 -0400
Received: by mail-io0-f180.google.com with SMTP id f102so3555509ioi.2
        for <linux-sparse@vger.kernel.org>; Tue, 09 May 2017 16:21:08 -0700 (PDT)
In-Reply-To: <508829304.6362470.1494351759113.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, May 9, 2017 at 10:42 AM, Lance Richardson <lrichard@redhat.com> wrote:
>>             if (cond && cond->type == EXPR_VALUE &&
>> !const_expression_value(cond))
>
> This doesn't work for some cases.  E.g. for an expression like
> "sizeof(struct s) == 16", cond->type is EXPR_COMPARE before
> const_expression_value(cond) is called and is only set to EXPR_VALUE after
> the call has reduced the expression to a value. I was looking at this test
> as a way to verify that const_expression_value() was successful.


OK. That make sense.


>>
>> > +               sparse_error(cond->pos, "static assertion failed: %s",
>> > +                            show_string(message->string));
>>
>> Then there:
>>            message ?  show_string(message->string) : "");
>>
>> I think the assert failed without message string, we already report
>> the error on empty string
>> expression. Raising the assert here might be acceptable?
>>
>
> I was taking the more conservative approach of not assuming anything
> about the interpretation of the two expressions if the assertion is not
> syntactically correct. This seems like a better way to go.

That is fine you chose that way.

Chris

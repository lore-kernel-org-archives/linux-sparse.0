From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] add support for __int128
Date: Tue, 7 Feb 2017 11:05:19 +0800
Message-ID: <CANeU7QnmjMr30T7SgRMTi9v_+XhKkexhm0=nbHvnyr7q_cbdiQ@mail.gmail.com>
References: <20161209230311.36024-1-luc.vanoostenryck@gmail.com>
 <20161209230311.36024-3-luc.vanoostenryck@gmail.com> <CANeU7Qk88LOkmwa3KFSawO+HH=tJyEQi-rOKxkofdDDb-3xb+w@mail.gmail.com>
 <CAMHZB6Hc9qwOve85K7Ji27eEL-dK90fDGebv_U3MgGmF58WFgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34792 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbdBGDFU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Feb 2017 22:05:20 -0500
Received: by mail-io0-f194.google.com with SMTP id c80so11625433iod.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Feb 2017 19:05:20 -0800 (PST)
In-Reply-To: <CAMHZB6Hc9qwOve85K7Ji27eEL-dK90fDGebv_U3MgGmF58WFgQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 7, 2017 at 10:49 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>> @@ -1496,6 +1504,8 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
>>>                         }
>>>                         seen |= s->op->set;
>>>                         class += s->op->class;
>>> +                       if (s->op->set & Set_Int128)
>>> +                               size = 2;
>>>                         if (s->op->type & KW_SHORT) {
>>>                                 size = -1;
>>>                         } else if (s->op->type & KW_LONG && size++) {
>>
>> This patch is already applied in sparse-next.
>> But I have a question regarding the "size = 2;" Is the number 2 a magic
>> number?
>
> Not really magic but certainly not obvious:
> * 'size' acts here as a sort of modifiers for interger
> * plain integer, 'int' thus, are set to 'size = 0'
> * then if 'short' is encountered, it's set to 'size = -1'
> * each 'long' increment size by 1
> * so int = 0, long = 1, long long = 2 & long long long = 3
> * here __int128 is in fact 'long long long' so should ends to 3
>   but the code contained a 'size++' which explain the 'size = 2'
>   I had to had to support this type.
>
> To be honest I don't like much what is done with this 'size' but
> it works and I always try to make the smallest change in the
> pre-existing code.
>

Adding the sparse mailing list.

Thanks for the explain regarding the size. So the size is actually the
how many extra int in terms of size.

In that case, maybe we can add define/enum SIZE_128_BIT as 2,
SIZE_SHORT as -1 etc together with your comment.

Chris

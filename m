From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential problem with variable handling - Was: Handling of local
 variables in the backend
Date: Wed, 13 Sep 2017 14:07:34 +0100
Message-ID: <CACXZuxexegxsogqdWgwWvLTC554X_sZsHUqd39g-jTJfHHpgNQ@mail.gmail.com>
References: <CACXZuxfTMQVZqkL4kJr6pAo0wfUC-PA+P1WPLS9b9jGsEd1Yew@mail.gmail.com>
 <CAExDi1R2d+MFisBKF0y6zkpou=7Vrw8qSffbxgCa2b9+8rR+VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:43849 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbdIMNHg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Sep 2017 09:07:36 -0400
Received: by mail-ua0-f179.google.com with SMTP id g47so234994uad.0
        for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2017 06:07:36 -0700 (PDT)
In-Reply-To: <CAExDi1R2d+MFisBKF0y6zkpou=7Vrw8qSffbxgCa2b9+8rR+VA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 13 September 2017 at 12:55, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Sep 13, 2017 at 1:37 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> Hi,
>>
>>
>> I have been thinking about this issue for some time - i.e. that the
>> Sparse IR does not explicitly define or initialize local variables.
>
> The problem of undefined variables is one thing (that the SSA conversion
> can and should deal with).
>
>> The back-end deals with it by doing it at first access. But this could
>> result in incorrect behavior if the initialization was meant to occur
>> at a certain point in the code. I should probably try to prove this
>> theory by creating a test - but intuitively it seems that if the
>> programmer had meant to initialize a variable at a particular point,
>> there could be a reason why it should be done at that point and not
>> some point later.
>
> Unless you access the variables by some means the compiler is not aware
> of, it must not matter.
>
> And in all case, the initialization must be done when the following rules
> (scopes, sequence points, ...) and the compiler is free to do anything
> 'as if' these rules are respected.
>

Yes, it seems this is okay as the store instruction (from
initialization) occurs at the right place.

Regards
Dibyendu

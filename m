From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential problem with variable handling - Was: Handling of local
 variables in the backend
Date: Wed, 13 Sep 2017 15:42:56 +0200
Message-ID: <CAExDi1T=oVvh5R9PJbw3pydPBSiJw27Vq_bSBgrXBYP1-wGO1g@mail.gmail.com>
References: <CACXZuxfTMQVZqkL4kJr6pAo0wfUC-PA+P1WPLS9b9jGsEd1Yew@mail.gmail.com>
 <CAExDi1R2d+MFisBKF0y6zkpou=7Vrw8qSffbxgCa2b9+8rR+VA@mail.gmail.com> <CACXZuxexegxsogqdWgwWvLTC554X_sZsHUqd39g-jTJfHHpgNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:46616 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdIMNm6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Sep 2017 09:42:58 -0400
Received: by mail-lf0-f47.google.com with SMTP id m199so721378lfe.3
        for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2017 06:42:57 -0700 (PDT)
In-Reply-To: <CACXZuxexegxsogqdWgwWvLTC554X_sZsHUqd39g-jTJfHHpgNQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 13, 2017 at 3:07 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 13 September 2017 at 12:55, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Wed, Sep 13, 2017 at 1:37 PM, Dibyendu Majumdar
>> <mobile@majumdar.org.uk> wrote:
>>> Hi,
>>>
>>>
>>> I have been thinking about this issue for some time - i.e. that the
>>> Sparse IR does not explicitly define or initialize local variables.
>>
>> The problem of undefined variables is one thing (that the SSA conversion
>> can and should deal with).
>>
>>> The back-end deals with it by doing it at first access. But this could
>>> result in incorrect behavior if the initialization was meant to occur
>>> at a certain point in the code. I should probably try to prove this
>>> theory by creating a test - but intuitively it seems that if the
>>> programmer had meant to initialize a variable at a particular point,
>>> there could be a reason why it should be done at that point and not
>>> some point later.
>>
>> Unless you access the variables by some means the compiler is not aware
>> of, it must not matter.
>>
>> And in all case, the initialization must be done when the following rules
>> (scopes, sequence points, ...) and the compiler is free to do anything
>> 'as if' these rules are respected.
>>
>
> Yes, it seems this is okay as the store instruction (from
> initialization) occurs at the right place.

Yes, but the 'place' (or 'time') is not the right concept.
The only thing that matter is for subsequent loads to see the
correct values. Thus everything is legit and correct as long as
the store-load dependencies are respected.
If you use pointers or if the variables can be in one way or another
be aliased between each other, then it's not simply the store-load
dependencies of this variable that must be respected but all
(possible) dependencies between all aliases (and partial aliases).

-- Luc

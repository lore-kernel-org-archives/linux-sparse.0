From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 0/3] assorted LLVM fixes
Date: Tue, 15 Aug 2017 00:56:44 +0100
Message-ID: <CACXZuxfsJUS7H9TSzc4tvtO4R9NkxNj5h_fPwEd26bTFnp6QvQ@mail.gmail.com>
References: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qmbs9FZqw1ZNRY7=ZyDjuL3OWMMyjeO_cUBRzpb-=wBbA@mail.gmail.com>
 <CAExDi1T6H4YA28DuPU3ic+qK1-nbP+UycQA+FqPG9XvMiQhhXQ@mail.gmail.com> <CANeU7Q=8+E8KibEPtOPwizvTc2dWj3TEQgqAuFkVvBaSoaritQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38188 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752651AbdHNX4p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 19:56:45 -0400
Received: by mail-ua0-f195.google.com with SMTP id x24so5771516uah.5
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 16:56:44 -0700 (PDT)
In-Reply-To: <CANeU7Q=8+E8KibEPtOPwizvTc2dWj3TEQgqAuFkVvBaSoaritQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 14 August 2017 at 21:31, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 14, 2017 at 4:29 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> They make no sense to be applied alone. As written here above
>> they are "supposed to be applied on top of all others LLVM fixes".
>>
> Yes, I know.
>
> That is what I am saying, after the this release. Hopefully this
> Wednesday. We can start merging the your base patches for
> the LLVM fix. Not this one.
>

I suggest that immediately after the release as a priority please
could you merge Luc's SSA work. I merged this today into my repository
- and it is looking good. I think LLVM changes / and all else should
follow only after the new SSA construction is in place.

Regards
Dibyendu

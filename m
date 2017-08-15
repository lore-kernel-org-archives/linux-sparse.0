From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/3] assorted LLVM fixes
Date: Mon, 14 Aug 2017 20:42:03 -0400
Message-ID: <CANeU7Qm76xtKR5p2oHr0EB5onCnLmFow9QLi7nJd5OBbUbF2xg@mail.gmail.com>
References: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qmbs9FZqw1ZNRY7=ZyDjuL3OWMMyjeO_cUBRzpb-=wBbA@mail.gmail.com>
 <CAExDi1T6H4YA28DuPU3ic+qK1-nbP+UycQA+FqPG9XvMiQhhXQ@mail.gmail.com>
 <CANeU7Q=8+E8KibEPtOPwizvTc2dWj3TEQgqAuFkVvBaSoaritQ@mail.gmail.com> <CACXZuxfsJUS7H9TSzc4tvtO4R9NkxNj5h_fPwEd26bTFnp6QvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36291 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752890AbdHOAmE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 20:42:04 -0400
Received: by mail-yw0-f178.google.com with SMTP id u207so64391726ywc.3
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 17:42:04 -0700 (PDT)
In-Reply-To: <CACXZuxfsJUS7H9TSzc4tvtO4R9NkxNj5h_fPwEd26bTFnp6QvQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 14, 2017 at 7:56 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I suggest that immediately after the release as a priority please
> could you merge Luc's SSA work. I merged this today into my repository
> - and it is looking good. I think LLVM changes / and all else should
> follow only after the new SSA construction is in place.
>
Still need to properly reviewed. It will spend some time on this in
these two days. If you already have it in your tree and tested.
That is good. It can buy me some time to review it.

I do want to get the SSA form properly. There is no question about it.

Chris

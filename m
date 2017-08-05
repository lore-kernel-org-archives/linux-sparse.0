From: Christopher Li <sparse@chrisli.org>
Subject: Re: what is cooking in sparse-next-20170805
Date: Sat, 5 Aug 2017 10:19:55 -0400
Message-ID: <CANeU7QnBpmP9Q=1jS+S_row2L6dyrpfyhEkKDTnYpzvkit0MiA@mail.gmail.com>
References: <CANeU7Q=PetPO=LujGB9mk6RhzJz9aQivYNgx=_4Eht3XMrPFCA@mail.gmail.com>
 <CANeU7Q=TjwwwNH4+iA=Qd-qPY8Kz0KmTNwtHQNstc8ERO5SZnA@mail.gmail.com> <CACXZuxet7TCfunMsp_vARb96VZ4-=OdwzjEMQK1dJR_Jfs+-Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36295 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdHEOT4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 10:19:56 -0400
Received: by mail-pf0-f179.google.com with SMTP id c28so17411320pfe.3
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 07:19:56 -0700 (PDT)
In-Reply-To: <CACXZuxet7TCfunMsp_vARb96VZ4-=OdwzjEMQK1dJR_Jfs+-Aw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sat, Aug 5, 2017 at 9:56 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Chris,
>
> Does sparse-next now have all the changes/fixes since January? I am
> still waiting for this to stabilize before attempting a merge into my
> project.

No. The master branch is the stable point. The sparse-next is playground
for testing patches before merge to master. The history in sparse-next
can get rewrite to remove some temporary fix.

For all the patches, especially the llvm one you are waiting for.
Have to wait for Luc resend the merge request after the release.
This release is just get some stable bits out first. Serve as anchor
point for the coming merges.

Right now we don't have blocker or know to be broken issue
on sparse. The release should happen relative soon.
Famous last word.


Chris

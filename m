From: Christopher Li <sparse@chrisli.org>
Subject: Re: RFC: Move Sparse development to github
Date: Thu, 10 Aug 2017 07:46:25 -0400
Message-ID: <CANeU7Q=dX9ZbnmsuSS19bJMdpieUtqdJzExTCbfKNHdnDqnzog@mail.gmail.com>
References: <CACXZuxfUbrV5P0aoTfOvfaX3RDW=Nc2-BPfXj1DLENznt_TE4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33805 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbdHJLq1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 07:46:27 -0400
Received: by mail-yw0-f172.google.com with SMTP id s143so2899971ywg.1
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 04:46:26 -0700 (PDT)
In-Reply-To: <CACXZuxfUbrV5P0aoTfOvfaX3RDW=Nc2-BPfXj1DLENznt_TE4Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 6:58 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I would like to propose moving Sparse development to github. The model
> I would like to propose is as follows:

It does not need to be move from the release stand point of view.
I already have an github account and github repository of sparse.

I can merge the merge request from github (not using the github UI though).
The merge will reflect on github. That should satisfy most of your
points here.

A lot of time is spend on the discussion and figure out what is the
right thing to do. I still like the review before commit model. If Luc
want to make this is clear this is a git pull request I want this pull.
It be pull rather quickly using the current master model. A lot of time
I need to clarify weather the patch is for release or for view.

I can sync the master to github every time I push to korg. That part
is easy.

I am not a big fan of using the github UI for merge though. I can read the
github issue request there fine.

What you are really asking is having Luc on github has his own
sparse tree. Not just patches.  I totally support of that too. I would be
happy to pull from his tree.

I still prefer the review and merge model for release though.

Thanks

Chris

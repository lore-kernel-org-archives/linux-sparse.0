From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL v5] fix list corruption with recursive remove_usage()
Date: Wed, 9 Aug 2017 21:19:30 -0400
Message-ID: <CANeU7Qm3y5UOWKPdDcJ_vVWdmeLw+fsqLv4buwp-E+=n04aRQg@mail.gmail.com>
References: <20170808020022.12729-1-luc.vanoostenryck@gmail.com> <CANeU7Qm1+eJYJmeUtY1Hjc9u5VUfpYHT-LLyfCRaXEOVTg_E-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36042 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdHJBTb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 21:19:31 -0400
Received: by mail-yw0-f181.google.com with SMTP id u207so50218274ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 18:19:31 -0700 (PDT)
In-Reply-To: <CANeU7Qm1+eJYJmeUtY1Hjc9u5VUfpYHT-LLyfCRaXEOVTg_E-Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 10:19 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Let me repeat. The "for-chris" branch should:
> 1. fast forwardable from master
> 2. contain *all* of the patches from you that want me to pull.
>
> "for-chris" doesn't need to be always fast forward-able to the
> last "for-chris" point.
>
> If you need to fix the "for-chris" for some v4-> v5. Go ahead
> and rebase the "for-chris" as you like. It is your call how to
> make "for-chris" stable the way you like.
>
> The implications is that. You practically define the stable part
> of  the master branch. My sparse-next will always use your
> "for-chris" as base.
>
> I think that will be the best way for our current development
> model. It give you to control the stable point on master, it give
> me the flexibility to rebase spase-next.

Please ignore that.  I will drop the rebase on sparse-next and
do integration on master. Master will never rebase and rollback.
If there is a bug get merged. It will be fix as new commits to master.

Chris

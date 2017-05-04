From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] pending fixes for sparse's next release
Date: Wed, 3 May 2017 21:37:17 -0400
Message-ID: <CANeU7QkgH+Z=f5Lw_AY38J1UMuN4qL8cMOWBWZWR5hw0J78weg@mail.gmail.com>
References: <20170430034149.iltu3kctg6n7w4g2@macpro.local> <CANeU7QkKubmzFjfbSqN0aQ=rwo=XJKtM1BfDHrb3Z3Nuc=VkKw@mail.gmail.com>
 <20170503223020.43cj45t4smjhw6qc@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35845 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932179AbdEDBhT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 21:37:19 -0400
Received: by mail-it0-f45.google.com with SMTP id o5so5516945ith.1
        for <linux-sparse@vger.kernel.org>; Wed, 03 May 2017 18:37:18 -0700 (PDT)
In-Reply-To: <20170503223020.43cj45t4smjhw6qc@desk.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 3, 2017 at 6:30 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I see it as 'sparse-next-20170501' while 'sparse-next' contains
> (a27c14511 "Add more declarations for more builtin functions").
> Is it like this it should be?

Oh, no. Thanks for the catch.

I did not reset sparse-next properly. Let me redo it.

Chris

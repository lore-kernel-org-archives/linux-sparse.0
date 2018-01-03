From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] ctags: avoid null deref
Date: Wed, 3 Jan 2018 17:43:53 +0100
Message-ID: <20180103164352.k3ltsfjzjkoc22hl@ltop.local>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
 <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
 <20180102151116.22060-3-luc.vanoostenryck@gmail.com>
 <20180103155523.2f1fa60bd0d4a9f708016f8a@redchan.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35404 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeACQn4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 Jan 2018 11:43:56 -0500
Received: by mail-wm0-f50.google.com with SMTP id a79so3691219wma.0
        for <linux-sparse@vger.kernel.org>; Wed, 03 Jan 2018 08:43:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180103155523.2f1fa60bd0d4a9f708016f8a@redchan.it>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: foobar <foobar@redchan.it>
Cc: linux-sparse@vger.kernel.org

On Wed, Jan 03, 2018 at 03:55:23PM +0000, foobar wrote:
> Luc, thank you for addressing this issue so quickly!
> 
> On Tue,  2 Jan 2018 16:11:16 +0100
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
> 
> > Protect the dereference of null base_type.
> 
> I wonder, maybe it would be better not to add this protection so future similar bugs can be found ?

When there have been a previous error, a warning is issued and
often (but depending on the exact nature of the problem)
the returned pointer is null. So it's kinda normal to have
such pointer and we need to test them before continuing.
So, I really think the patch here is needed.

-- Luc

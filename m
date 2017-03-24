From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v4 02/63] allow binop simplification after canonicalization
Date: Thu, 23 Mar 2017 22:00:17 -0700
Message-ID: <CANeU7QkUC1kZPq8s_Z-HWWri=edi6SczhGEaNFydEArRcN2J8w@mail.gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com> <20170321001607.75169-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35785 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbdCXFAT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 01:00:19 -0400
Received: by mail-io0-f177.google.com with SMTP id z13so10573894iof.2
        for <linux-sparse@vger.kernel.org>; Thu, 23 Mar 2017 22:00:18 -0700 (PDT)
In-Reply-To: <20170321001607.75169-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Mon, Mar 20, 2017 at 5:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  simplify.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Looks good. It would be nice to have some test code to show the effect
of this change.

Chris

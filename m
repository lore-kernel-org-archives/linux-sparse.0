From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 07:48:30 +0100
Message-ID: <CAExDi1TRL+zXQ_C5iDiVuWkUdmk8A=-sd1PRAzeZY7QdWirKNg@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CACXZuxd+SKSFxB5S0y9-bGep64_Vvpw3SvqDQqeKNzo3dtw_Mg@mail.gmail.com>
 <CACXZuxeq=ZOTroVmtHqjNpPzFw-nvu4beWfXeVUhBnaBt12gjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33167 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdCBGsc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 01:48:32 -0500
Received: by mail-qk0-f169.google.com with SMTP id n127so109098750qkf.0
        for <linux-sparse@vger.kernel.org>; Wed, 01 Mar 2017 22:48:31 -0800 (PST)
In-Reply-To: <CACXZuxeq=ZOTroVmtHqjNpPzFw-nvu4beWfXeVUhBnaBt12gjA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 28, 2017 at 5:49 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I should add that if (int *) is used instead of (void *) in the above
> example, it still aborts, although this time the changes I suggested
> are not relevant.

Strange. It seems to work correctly for me.

Luc

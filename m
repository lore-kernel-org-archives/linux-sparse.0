From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Adding an option to sparse to disable the IR simplifications
Date: Mon, 14 Aug 2017 18:46:56 +0200
Message-ID: <CAExDi1S+g2AVH-wn4zAG1OiQPZKCb7x2kuSvD=-niPO1Yivhqw@mail.gmail.com>
References: <CACXZuxeJGkN26dYEbs6smHvd6XyLnjtNFciZ1wJCVto4Z0nodw@mail.gmail.com>
 <CACXZuxdoLAW4rtk=zgwor9hVj8cxZ5GwSKGMSQUis_eWRiQ4GA@mail.gmail.com> <CACXZuxeyNL_OE0geog_TJPGtWj5TCP2CyX5UHeKxERvzsthbBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:32993 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbdHNQq6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 12:46:58 -0400
Received: by mail-oi0-f52.google.com with SMTP id f11so89149826oic.0
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 09:46:57 -0700 (PDT)
In-Reply-To: <CACXZuxeyNL_OE0geog_TJPGtWj5TCP2CyX5UHeKxERvzsthbBw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Mon, Aug 14, 2017 at 6:38 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I suggested a while back that it might be useful to add an option to
> control the simplifications.
>
> In dmrC the simplification phase is turned off by default. But if you
> supply -O1 option then it is turned on. This ensures that  I can test
> both the unsimplified and simplified versions.

Yes, it's something that more useful now than it was months ago.
I think I'll first move some code around though.

-- Luc

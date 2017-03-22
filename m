From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Adding an option to sparse to disable the IR simplifications
Date: Wed, 22 Mar 2017 20:53:29 +0000
Message-ID: <CACXZuxdoLAW4rtk=zgwor9hVj8cxZ5GwSKGMSQUis_eWRiQ4GA@mail.gmail.com>
References: <CACXZuxeJGkN26dYEbs6smHvd6XyLnjtNFciZ1wJCVto4Z0nodw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38206 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932208AbdCVUxb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 16:53:31 -0400
Received: by mail-it0-f43.google.com with SMTP id y18so30345837itc.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 13:53:30 -0700 (PDT)
In-Reply-To: <CACXZuxeJGkN26dYEbs6smHvd6XyLnjtNFciZ1wJCVto4Z0nodw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 22 March 2017 at 19:56, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> With the progress made with spars-llvm in recent weeks we are now
> beginning to hit bugs in the simplifications carried out by the
> linearizer. So it is useful I think to have an ability to turn off
> these modifications - perhaps by a command line argument. This will
> enable testing of sparse-llvm with and without the simplifications,
> and help identify issues caused by the latter phase.
>

It appears that there is already an optimize flag that is set by -O
option. Perhaps this flag can be utilized to control the level of
simplifications attempted.

Thanks and Regards
Dibyendu

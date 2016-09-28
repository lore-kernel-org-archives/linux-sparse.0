From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: ignore __assume_aligned__ attribute
Date: Wed, 28 Sep 2016 13:27:58 -0700
Message-ID: <CANeU7Qn_QODHq1mp-K7o-h5qbhoVdAQqdOGo9ncEYTH6hGF+ww@mail.gmail.com>
References: <1475088065-31142-1-git-send-email-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38293 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753204AbcI1U2A (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Sep 2016 16:28:00 -0400
Received: by mail-it0-f48.google.com with SMTP id n143so44572838ita.1
        for <linux-sparse@vger.kernel.org>; Wed, 28 Sep 2016 13:27:59 -0700 (PDT)
In-Reply-To: <1475088065-31142-1-git-send-email-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 28, 2016 at 11:41 AM, Lance Richardson <lrichard@redhat.com> wrote:
> The __assume_aligned__ attribute can be safely ignored, add it
> to the list of ignored attributes and add a test to verify that
> this attribute is ignored.

That looks good. I might duplicate one test case  for "assume_aligned"
in the finial commit.

Thanks

Chris

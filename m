From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/5] testsuite: make tests known to fail effectively fail
Date: Thu, 17 Nov 2016 22:16:58 +0800
Message-ID: <CANeU7QmPdVKHXUQEqxDt2AoHrLUPihaEMQu3Zq9wdbAEYHXKzQ@mail.gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com> <20161102214509.36571-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:38705 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcKQREB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:04:01 -0500
Received: by mail-it0-f46.google.com with SMTP id j191so62888715ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:04:00 -0800 (PST)
In-Reply-To: <20161102214509.36571-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 3, 2016 at 5:45 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> These tests must fail because some errors which should
> be detected are not.
> But the test suite lack to see that because those tests
> don't have the check-error-start/end section.
>
> Add such a section (with madeup error message) so that the
> testsuite now properly see and report the failure.

Applied.

Chris

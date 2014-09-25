From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Fix ioc type check
Date: Thu, 25 Sep 2014 20:10:16 +0800
Message-ID: <CANeU7Qkg9zBUoggGLBtFq6_-Svh9C2XHsFKdqvQ3TGaGNMZ79w@mail.gmail.com>
References: <8d1bffcadf496f52dc70063986684762344da771.1411633200.git.tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:49191 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbaIYMKR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Sep 2014 08:10:17 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so7840777wgh.12
        for <linux-sparse@vger.kernel.org>; Thu, 25 Sep 2014 05:10:16 -0700 (PDT)
In-Reply-To: <8d1bffcadf496f52dc70063986684762344da771.1411633200.git.tgraf@suug.ch>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, hans.verkuil@cisco.com

On Thu, Sep 25, 2014 at 4:20 PM, Thomas Graf <tgraf@suug.ch> wrote:
> Add missing exepcted error output for the test to pass.
>
> Fixes: 42ebe41 "Add test case for the ioc type check"
> Signed-off-by: Thomas Graf <tgraf@suug.ch>

No, this test case is some thing gcc can handle and sparse
can't. Instead of patching the test result, we need to fix sparse
to handle it correctly.

It is an open bug of sparse.

Chris

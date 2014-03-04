From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] evaluate: split out implementation of compatible_assignment_types
Date: Mon, 3 Mar 2014 21:05:37 -0800
Message-ID: <CANeU7QkAR2TNyrXGnTjSDuPFRseQ1ac_Wf9YSB+u9uFjOJM1ng@mail.gmail.com>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:64845 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaCDFLD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Mar 2014 00:11:03 -0500
Received: by mail-qa0-f46.google.com with SMTP id i13so4330064qae.5
        for <linux-sparse@vger.kernel.org>; Mon, 03 Mar 2014 21:11:02 -0800 (PST)
In-Reply-To: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Mar 1, 2014 at 3:41 AM, John Keeping <john@keeping.me.uk> wrote:
> This will allow us to reuse the logic when processing a transparent
> union by checking each member in turn without printing a warning unless
> none of the members match.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

The series looks fine on my first casual look.

Will get back to you on that.

Chris

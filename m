From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH] Add -fno-show-column
Date: Sat, 10 Jan 2009 14:36:21 -0800
Message-ID: <70318cbf0901101436o6ec6db6sf334c5d78a1f8967@mail.gmail.com>
References: <20090110141414.7093.82893.stgit@vmbox.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:38187 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbZAJWgV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 Jan 2009 17:36:21 -0500
Received: by rv-out-0506.google.com with SMTP id k40so9593866rvb.1
        for <linux-sparse@vger.kernel.org>; Sat, 10 Jan 2009 14:36:21 -0800 (PST)
In-Reply-To: <20090110141414.7093.82893.stgit@vmbox.hanneseder.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: linux-sparse@vger.kernel.org

On Sat, Jan 10, 2009 at 6:19 AM, Hannes Eder <hannes@hanneseder.net> wrote:
> Do not print column numbers in diagnostic messages.  This may be
> necessary if processing the diagnostic messages with a program that
> does not understand the column numbers.
>
> The default behaviour of sprase, to print the column numbers, is
> left as is by this patch.

Can you elaborate what program does not understand the
column numbers? If it is some program that we don't normally
care, I'd rather keep sparse simple.

Chris

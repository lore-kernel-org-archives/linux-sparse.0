From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Ignore "naked" attribute
Date: Mon, 30 Nov 2009 15:24:57 -0800
Message-ID: <70318cbf0911301524p2cca13l3ee61bbf19d446bf@mail.gmail.com>
References: <200911292359.13785.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:56037 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZK3XYw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Nov 2009 18:24:52 -0500
Received: by ey-out-2122.google.com with SMTP id 4so1061356eyf.19
        for <linux-sparse@vger.kernel.org>; Mon, 30 Nov 2009 15:24:57 -0800 (PST)
In-Reply-To: <200911292359.13785.mb@bu3sch.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-sparse@vger.kernel.org

On Sun, Nov 29, 2009 at 2:59 PM, Michael Buesch <mb@bu3sch.de> wrote:
> The GCC "naked" attribute is used on certain architectures to generate
> functions without a prologue/epilogue.
>
> Ignore it in sparse.
Applied.

Thanks,

Chris

From: Christopher Li <sparse@chrisli.org>
Subject: Re: fun with declarations and definitions
Date: Thu, 5 Feb 2009 10:52:31 -0800
Message-ID: <70318cbf0902051052h7c1e0149s90dda738bcf55500@mail.gmail.com>
References: <20090202073018.GB28946@ZenIV.linux.org.uk>
	 <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
	 <20090203044156.GI28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:22946 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZBESwd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 13:52:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so387430rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 05 Feb 2009 10:52:31 -0800 (PST)
In-Reply-To: <20090203044156.GI28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 2, 2009 at 8:41 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Yuck.   That's a leftover that hadn't been caught since it affects only
> K&R definitions.  Kill that line...

Apply and pushed.

Chris

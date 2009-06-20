From: Samuel Bronson <naesten@gmail.com>
Subject: Re: RFC: Move sparse.git inside linux-kernel-2.6.git?
Date: Sat, 20 Jun 2009 15:37:37 -0400
Message-ID: <db65a1cd0906201237ya3e9bfbmf7a106b72a450f7f@mail.gmail.com>
References: <20090618192058.GB14086@uranus.ravnborg.org>
	 <70318cbf0906181340j3b04b2b4hb95f6c8648dea70b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:57583 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbZFTThf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 Jun 2009 15:37:35 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1401131ywb.1
        for <linux-sparse@vger.kernel.org>; Sat, 20 Jun 2009 12:37:38 -0700 (PDT)
In-Reply-To: <70318cbf0906181340j3b04b2b4hb95f6c8648dea70b@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jun 18, 2009 at 4:40 PM, Christopher Li<sparse@chrisli.org> wrote:

> We can even make some build target in the kernel to check out a copy
> of the sparse tree in the tools/sparse directory. That should solve the
> problem that people need to know where to check out.

About that ... shouldn't the URL on the sparse web page be
"git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git", not
"git://git.kernel.org/pub/scm/devel/sparse/sparse.git"?

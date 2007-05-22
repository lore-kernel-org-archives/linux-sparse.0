From: "Damien Lespiau" <damien.lespiau@gmail.com>
Subject: Re: [PATCH] Fix compilation warning on 64 bits platforms
Date: Tue, 22 May 2007 20:06:34 +0200
Message-ID: <cbf3148c0705221106n68cacf3g82faeba38d964945@mail.gmail.com>
References: <11797058752907-git-send-email-damien.lespiau@gmail.com>
	 <4650E7B5.4030207@freedesktop.org>
	 <20070521003318.GB4095@ftp.linux.org.uk>
	 <4650E990.3020305@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:40301 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758322AbXEVSGf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 14:06:35 -0400
Received: by wx-out-0506.google.com with SMTP id h29so309202wxd
        for <linux-sparse@vger.kernel.org>; Tue, 22 May 2007 11:06:34 -0700 (PDT)
In-Reply-To: <4650E990.3020305@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

> Al Viro wrote:
> > Not just glibc; it's in C99.  So yes, I'd say we should use %td here.

Much better than my ugly cast. I feel stupid to "sign" a one letter patch
that is not mine, but I guess you expect me to resend it.

-- 
Damien

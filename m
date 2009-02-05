From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: fun with declarations and definitions
Date: Thu, 05 Feb 2009 18:47:17 +0000
Message-ID: <498B3435.8010506@knosof.co.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk>	 <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>	 <20090203041317.GH28946@ZenIV.linux.org.uk> <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:55027 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760470AbZBESrc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 13:47:32 -0500
In-Reply-To: <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

Christopher,

> Right. I think currently sparse treat the subsequent declaration like a new
> one. It check the type is compatible with previous declaration. But it does
> not merge the previous declaration information.

Sparse needs to generate composite types:
http://c0x.coding-guidelines.com/6.2.7.html

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk

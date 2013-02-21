From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: add noclone as an ignored attribute
Date: Thu, 21 Feb 2013 15:35:58 -0800
Message-ID: <CANeU7Qk+5RMN--w_BQpUoX5yh_fkdfme7AxVpm3HXVyZX_inJQ@mail.gmail.com>
References: <51184E28.40909@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:42004 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab3BUXgC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 21 Feb 2013 18:36:02 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so81130oag.16
        for <linux-sparse@vger.kernel.org>; Thu, 21 Feb 2013 15:35:59 -0800 (PST)
In-Reply-To: <51184E28.40909@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Feb 10, 2013 at 5:49 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Add attribute "noclone" or "__noclone" or "__noclone__" as an
> ignored attribute. Fixes this sparse warning:
>
> arch/x86/kvm/vmx.c:6268:13: error: attribute '__noclone__': unknown attribute

The change looks good. Can you add a test case for the noclone attribute
in the validations directory? I am happy to apply it.

Chris

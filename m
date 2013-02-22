From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse patch v2: add noclone as an ignored attribute
Date: Thu, 21 Feb 2013 16:56:26 -0800
Message-ID: <CANeU7QntUuLTCzNqXjgWmS67y=71xbSVWQhFgA3nvRVntpnoOg@mail.gmail.com>
References: <51184E28.40909@infradead.org>
	<CANeU7Qk+5RMN--w_BQpUoX5yh_fkdfme7AxVpm3HXVyZX_inJQ@mail.gmail.com>
	<5126B9E1.1070007@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48287 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab3BVA41 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 21 Feb 2013 19:56:27 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so121544obc.4
        for <linux-sparse@vger.kernel.org>; Thu, 21 Feb 2013 16:56:26 -0800 (PST)
In-Reply-To: <5126B9E1.1070007@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Feb 21, 2013 at 4:20 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Add attribute "noclone" or "__noclone" or "__noclone__" as an
> ignored attribute. Fixes this sparse warning:

Thanks, applied.

Chris

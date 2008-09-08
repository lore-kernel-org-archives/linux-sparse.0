From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Unused arg_count field
Date: Mon, 8 Sep 2008 13:40:36 -0700
Message-ID: <70318cbf0809081340g4bdd58fbn572c849bef7a010b@mail.gmail.com>
References: <48C2A96E.5020802@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:35872 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYIHUki (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Sep 2008 16:40:38 -0400
Received: by el-out-1112.google.com with SMTP id z25so151027ele.1
        for <linux-sparse@vger.kernel.org>; Mon, 08 Sep 2008 13:40:36 -0700 (PDT)
In-Reply-To: <48C2A96E.5020802@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Sep 6, 2008 at 9:01 AM, David Given <dg@cowlark.com> wrote:
> I notice that struct symbol::arg_count doesn't appear to be used,
> anywhere. Is this obsolete?
>

Indeed. This is not used.

Chris

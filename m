From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 15/16] deal with enum members without excessive PITA
Date: Thu, 13 Dec 2007 16:18:21 -0800
Message-ID: <70318cbf0712131618k6b3ffc98ibbf68156dc67b52e@mail.gmail.com>
References: <E1I2N6L-0003fT-82@ZenIV.linux.org.uk>
	 <OFAE867B27.E1902CE8-ONC12573B0.004D30CA-C12573B0.004EE4A1@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:1818 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762303AbXLNASV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Dec 2007 19:18:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so733267rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 13 Dec 2007 16:18:21 -0800 (PST)
In-Reply-To: <OFAE867B27.E1902CE8-ONC12573B0.004D30CA-C12573B0.004EE4A1@br-automation.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

It seems there is not good way to get the enum members from the parent symbol.
It should be trivial make a patch to add members to the parent
symbol->symbol_list though.

Chris


On Dec 13, 2007 6:21 AM, Thomas Schmid <Thomas.Schmid@br-automation.com> wrote:
> Hello Al,
>
> I just saw your patch for enum members, really late, I know.
>
> But i've got a question: If I've got the symbol for a global enum - how do
> I get from this to the symbols for the enum members?
> If there is no way, I've got to loop over all symbols within global_scope,
> right?
>
> Best regards
> Thomas Schmid
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

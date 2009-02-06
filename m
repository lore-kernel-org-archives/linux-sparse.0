From: Christopher Li <sparse@chrisli.org>
Subject: Re: Initializing float variables without type suffix
Date: Thu, 5 Feb 2009 20:15:37 -0800
Message-ID: <70318cbf0902052015i387c5e18w475704b290904e61@mail.gmail.com>
References: <1216938210.5455.16.camel@josh-work.beaverton.ibm.com>
	 <OFC65EA87B.BAADFE01-ONC1257553.004CCDB9-C1257553.00522B4E@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:62447 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbZBFEPh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 23:15:37 -0500
Received: by rv-out-0506.google.com with SMTP id k40so600380rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 05 Feb 2009 20:15:37 -0800 (PST)
In-Reply-To: <OFC65EA87B.BAADFE01-ONC1257553.004CCDB9-C1257553.00522B4E@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org

On Wed, Feb 4, 2009 at 6:57 AM, Thomas Schmid
<Thomas.Schmid@br-automation.com> wrote:
> Hello,
>
> i think i found an error, when float variables are initialized.
> Parsing the line
>
> float var = 1.2345;
>
> gets casted with the function cast_to(). It seems that cast_to() doesn't
> make double to float casts.

cast_to() seems fine.

In expanding stage, cast_value() did not cast the constant
correctly.

Chris

From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: [patchset] rewrite of initializer handling
Date: Tue, 19 Jun 2007 22:15:49 +0200
Message-ID: <46783975.4080704@redhat.com>
References: <20070618101929.GE21478@ftp.linux.org.uk> <4676CC9C.3050903@freedesktop.org> <20070618191653.GG21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54999 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761659AbXFSUQT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Jun 2007 16:16:19 -0400
In-Reply-To: <20070618191653.GG21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Al Viro wrote:
> On Mon, Jun 18, 2007 at 11:19:08AM -0700, Josh Triplett wrote:
>> How much spew does -Wparen-string cause?  If you feel that it always
>> represents an error, or at least sloppy code, and that it won't drown people
>> in warnings, I have no problem with turning it on by default.  Your call.
> 
> Depends on a project.  In case of kernel it's mostly a spew in s2io.c
> around
> static char ethtool_driver_stats_keys[][ETH_GSTRING_LEN] = {
>         {"\n DRIVER STATISTICS"},
>         {"single_bit_ecc_errs"},
>         {"double_bit_ecc_errs"},
>         {"parity_err_cnt"},
>         {"serious_err_cnt"},
>         {"soft_reset_cnt"},
>         {"fifo_full_cnt"},
>         {"ring_full_cnt"},
>         ("alarm_transceiver_temp_high"),
>         ("alarm_transceiver_temp_low"),
>         ("alarm_laser_bias_current_high"),
>         ("alarm_laser_bias_current_low"),
>         ("alarm_laser_output_power_high"),
> ....
> 
> Mind you, both braces and parentheses are redundant here, but the latter
> happen to be invalid C as well (and we want at least consistency anyway).
> 
> Other projects may differ.  IOW, I'd probably keep it optional.
Not sure if this is a poll but -Wparen-string doesn't add any new
warnings to the Wine run. And Wine has a "strange" way of specifying
wide char strings.

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart

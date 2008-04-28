From: "Chris Li" <christ.li@gmail.com>
Subject: Re: A few notes on how I see the whole process working.
Date: Mon, 28 Apr 2008 13:29:11 -0700
Message-ID: <70318cbf0804281329j416eb99bxf1c74e38bfa97296@mail.gmail.com>
References: <f19298770804202112hcd32b7ch8c6ef357b9f7344e@mail.gmail.com>
	 <480C8856.4030805@kernel.org>
	 <f19298770804241315wca6a214x23a863c6fceb6009@mail.gmail.com>
	 <f19298770804280012t4505dc7oc6aba4e78417962b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:50924 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765183AbYD1U3M (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 28 Apr 2008 16:29:12 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2697647wra.1
        for <linux-sparse@vger.kernel.org>; Mon, 28 Apr 2008 13:29:12 -0700 (PDT)
In-Reply-To: <f19298770804280012t4505dc7oc6aba4e78417962b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Mon, Apr 28, 2008 at 12:12 AM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
>
>  I still don't buy the bytecode idea, but it seems that the macros are
>  not actually lost after being pre-processed, which was my main concern
>  against even thinking about dumping the sparse internal representation
>  into the generated sparse object files. Still wandering in the dark. Will
>  look closed when return.
>
I think the whole point of dumping the sparse output is dumping the
linearized byte code and it can be load from a later time.  If some information
is missing from the current byte code, you can add annotate byte code
instruction.
e.g. the inlined call instruction is add for the reason to identify
which code are inserted
by he inline function call. You can certainly do that for macro if you
really want. The sparse
checker is not really using the macro right now.

The sparse checker currently is running on the linearized byte code. What other
internal representation do you need?


Chris

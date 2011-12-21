From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 2/3] sparse, llvm: Add test case for <stdbool.h> type
Date: Wed, 21 Dec 2011 12:18:32 +0200
Message-ID: <CAOJsxLEOy+=xYUTieDpx6=GLUUXpCW0tv4g_Xd0Ow_qz3D7a6Q@mail.gmail.com>
References: <1324459528-9344-1-git-send-email-penberg@kernel.org>
	<1324459528-9344-2-git-send-email-penberg@kernel.org>
	<20111221095810.GA27308@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39510 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab1LUKSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 21 Dec 2011 05:18:32 -0500
Received: by ggdk6 with SMTP id k6so5374241ggd.19
        for <linux-sparse@vger.kernel.org>; Wed, 21 Dec 2011 02:18:32 -0800 (PST)
In-Reply-To: <20111221095810.GA27308@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Dec 21, 2011 at 11:25:27AM +0200, Pekka Enberg wrote:
>> As it turns out, our validation test harness doesn't catch <stdbool.=
h> related
>> breakage so add a minimal test case that does.
> [...]
>> --- /dev/null
>> +++ b/validation/backend/bool-test.c
>> @@ -0,0 +1,11 @@
>> +#include <stdbool.h>
>> +
>> +static bool return_false(void)
>> +{
>> + =A0 =A0 return false;
>> +}

On Wed, Dec 21, 2011 at 11:58 AM, Josh Triplett <josh@joshtriplett.org>=
 wrote:
> Do we want tests that depend on system header files?

I changed it to use _Bool instead. Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

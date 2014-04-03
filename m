From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse and anonymous unions
Date: Thu, 3 Apr 2014 12:15:16 -0700
Message-ID: <CANeU7Qn4Kk7c9w2nkcknENJUuBGZALQjT44Yy-0vU+jYpAs=tA@mail.gmail.com>
References: <53242AC7.9080301@xs4all.nl>
	<53391E67.2000306@xs4all.nl>
	<CA+55aFzs_O780hEowt9vg69-Kxfwzn5j1eL2F2Tzw4C56koeRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:48625 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbaDCTPR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Apr 2014 15:15:17 -0400
In-Reply-To: <CA+55aFzs_O780hEowt9vg69-Kxfwzn5j1eL2F2Tzw4C56koeRg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>

On Mon, Mar 31, 2014 at 10:17 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Chris, mind applying this one too? It removes more lines than it adds
> while fixing things, by removing the helper function that isn't good
> at anoymous unions, and using another one that does this all right..

The patch is applied. I add the signed off for you too, hope you don't mind.

Chris

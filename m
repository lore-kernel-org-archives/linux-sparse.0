From: "Anderson Lizardo" <anderson.lizardo@gmail.com>
Subject: Re: [PATCH 0/2] Improved flow graphs
Date: Wed, 16 May 2007 14:03:36 -0400
Message-ID: <5b5833aa0705161103w5748cc84l7c733e010307259d@mail.gmail.com>
References: <1179310281.31308.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:13854 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762309AbXEPSDi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 May 2007 14:03:38 -0400
Received: by nz-out-0506.google.com with SMTP id r28so657261nza
        for <linux-sparse@vger.kernel.org>; Wed, 16 May 2007 11:03:38 -0700 (PDT)
In-Reply-To: <1179310281.31308.54.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Sheridan <djs@postman.org.uk>
Cc: linux-sparse@vger.kernel.org

On 5/16/07, Dan Sheridan <djs@postman.org.uk> wrote:
> Example graph can be seen at
> http://www.postman.org.uk/djs52/example.png, generated with
>
>   ./graph validation/context.c | gvpr -f gvpr/return-paths | \
>     gvpr -f gvpr/subg-fwd -a good_while3 | dot -Tpng > /tmp/example.png

Hi,

I have a question regarding this specific example:

If I understand the code correctly, the node name is the stream line
number of the first instruction of the BB right? Is that why the call
edge for r() comes from 169/173 (and not from 170/174, as I would
expect)?

Nice work BTW.

Regards,
-- 
Anderson Lizardo
